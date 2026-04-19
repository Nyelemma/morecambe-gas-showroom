(function () {
  var REPAIR_MAIL_TO = "enquiries@morecambegas.co.uk";

  function line(label, value) {
    if (value === undefined || value === null || String(value).trim() === "") return "";
    return label + ": " + String(value).trim() + "\r\n";
  }

  function buildMailBody(data) {
    var body = "";
    body += line("Request type", data.subject);
    body += "\r\n";
    body += line("Name", data.name);
    body += line("Phone", data.phone);
    body += line("Email", data.email);
    body += line("Property address / postcode", data.address);
    body += line("Appliance / system", data.appliance);
    body += line("Urgency / situation", data.urgency);
    body += line("Fault description", data.fault);
    body += line("Error codes (if shown)", data.errorCodes);
    body += line("How long has this been an issue?", data.duration);
    body += line("Best time to contact me", data.contactTime);
    body += line("Best time for engineer visit", data.visitTime);
    body += line("Extra timing notes", data.timingNotes);
    body += line("Other details", data.other);
    return body.trim();
  }

  function initForm() {
    var form = document.getElementById("repair-request-form");
    if (!form) return;

    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var statusEl = document.getElementById("repair-request-status");
      if (statusEl) {
        statusEl.classList.remove("is-visible", "enquiry-status--error");
      }

      if (!REPAIR_MAIL_TO || REPAIR_MAIL_TO.indexOf("@") === -1) {
        if (statusEl) {
          statusEl.textContent =
            "Repair request email is not configured yet. Please edit repair-request.js and set REPAIR_MAIL_TO, or call 01524 409398.";
          statusEl.classList.add("enquiry-status--error", "is-visible");
        }
        return;
      }

      var fd = new FormData(form);
      var subject =
        (fd.get("mail_subject") || "").toString() || "Repair call out request — Morecambe Gas Services";
      var data = {
        subject: subject,
        name: fd.get("name"),
        phone: fd.get("phone"),
        email: fd.get("email"),
        address: fd.get("address"),
        appliance: fd.get("appliance"),
        urgency: fd.get("urgency"),
        fault: fd.get("fault_description"),
        errorCodes: fd.get("error_codes"),
        duration: fd.get("duration"),
        contactTime: fd.get("best_time_contact"),
        visitTime: fd.get("best_time_visit"),
        timingNotes: fd.get("timing_notes"),
        other: fd.get("other_details"),
      };

      var body = buildMailBody(data);
      var mailto =
        "mailto:" +
        REPAIR_MAIL_TO +
        "?subject=" +
        encodeURIComponent(subject) +
        "&body=" +
        encodeURIComponent(body);

      window.location.href = mailto;

      if (statusEl) {
        statusEl.textContent =
          "Your email app should open with this repair request ready to send. If nothing happens, call 01524 409398 or 07312 126456.";
        statusEl.classList.add("enquiry-status--info", "is-visible");
      }
    });
  }

  initForm();
})();
