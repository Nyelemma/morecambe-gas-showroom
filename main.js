(function () {
  var toggle = document.querySelector(".nav-toggle");
  var nav = document.querySelector(".nav-main");
  if (!toggle || !nav) return;

  toggle.addEventListener("click", function () {
    var open = nav.classList.toggle("is-open");
    toggle.setAttribute("aria-expanded", open ? "true" : "false");
  });

  document.querySelectorAll(".nav-main a").forEach(function (link) {
    link.addEventListener("click", function () {
      if (window.matchMedia("(max-width: 900px)").matches) {
        nav.classList.remove("is-open");
        toggle.setAttribute("aria-expanded", "false");
      }
    });
  });

  var header = document.querySelector(".site-header");
  var navLinks = document.querySelectorAll('.nav-main a[href^="#"]');
  if (header && navLinks.length && document.body.classList.contains("page-home")) {
    var sections = [];
    navLinks.forEach(function (a) {
      var id = a.getAttribute("href").slice(1);
      if (id && id !== "top") {
        var el = document.getElementById(id);
        if (el) sections.push({ id: id, el: el, link: a });
      }
    });

    function setActiveNav() {
      var headroom = header.offsetHeight + 10;
      var current = "top";
      for (var i = 0; i < sections.length; i++) {
        var rect = sections[i].el.getBoundingClientRect();
        if (rect.top <= headroom) current = sections[i].id;
      }
      navLinks.forEach(function (link) {
        var href = link.getAttribute("href");
        if (href === "#" + current) link.setAttribute("aria-current", "page");
        else link.removeAttribute("aria-current");
      });
    }

    var ticking = false;
    window.addEventListener(
      "scroll",
      function () {
        if (!ticking) {
          window.requestAnimationFrame(function () {
            setActiveNav();
            ticking = false;
          });
          ticking = true;
        }
      },
      { passive: true }
    );
    setActiveNav();
  }
})();
