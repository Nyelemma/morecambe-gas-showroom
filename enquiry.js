(function () {
  var ENQUIRY_MAIL_TO = "enquiries@morecambegas.co.uk";

  var PRESETS = {
    "service-contract": {
      subject: "Service contract enquiry — boiler and/or heating",
    },
    general: {
      subject: "General enquiry — Morecambe Gas Services",
    },
  };

  function getPreset() {
    var params = new URLSearchParams(window.location.search);
    var type = params.get("type") || "general";
    return PRESETS[type] ? PRESETS[type] : PRESETS.general;
  }

  function initContext() {
    var preset = getPreset();
    var subjectEl = document.getElementById("enquiry-mail-subject");
    if (subjectEl) subjectEl.value = preset.subject;
  }

  function line(label, value) {
    if (value === undefined || value === null || String(value).trim() === "") return "";
    return label + ": " + String(value).trim() + "\r\n";
  }

  function buildMailBody(data) {
    var body = "";
    body += line("Enquiry", data.subject);
    body += "\r\n";
    body += line("Name", data.name);
    body += line("Phone", data.phone);
    body += line("Email", data.email);
    body += line("Additional information (Boiler type, boiler age)", data.additionalInformation);
    return body.trim();
  }

  function bindMailtoForm(form) {
    if (!form) return;

    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var statusEl = form.querySelector(".enquiry-status");
      if (statusEl) {
        statusEl.classList.remove("is-visible", "enquiry-status--error");
      }

      if (!ENQUIRY_MAIL_TO || ENQUIRY_MAIL_TO.indexOf("@") === -1) {
        if (statusEl) {
          statusEl.textContent =
            "Enquiry email is not configured yet. Please edit enquiry.js and set ENQUIRY_MAIL_TO to your address, or call 01524 409398.";
          statusEl.classList.add("enquiry-status--error", "is-visible");
        }
        return;
      }

      var fd = new FormData(form);
      var subject = (fd.get("mail_subject") || "").toString() || "Enquiry — Morecambe Gas Services";
      var data = {
        subject: subject,
        name: fd.get("name"),
        phone: fd.get("phone"),
        email: fd.get("email"),
        additionalInformation: fd.get("additional_information"),
      };

      var body = buildMailBody(data);
      var mailto =
        "mailto:" +
        ENQUIRY_MAIL_TO +
        "?subject=" +
        encodeURIComponent(subject) +
        "&body=" +
        encodeURIComponent(body);

      window.location.href = mailto;

      if (statusEl) {
        statusEl.textContent =
          "Your email app should open with this enquiry ready to send. If nothing happens, check your device settings or call us on 01524 409398.";
        statusEl.classList.add("enquiry-status--info", "is-visible");
      }
    });
  }

  function initForms() {
    document.querySelectorAll("form.enquiry-mailto-form").forEach(bindMailtoForm);
  }

  initContext();
  initForms();
})();
