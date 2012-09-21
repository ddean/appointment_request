var Appointment = Backbone.Model.extend({

  url: function() {
    return "/appointments";
  }
});