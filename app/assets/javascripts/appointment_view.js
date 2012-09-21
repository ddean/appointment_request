$(function($) {
  var AppointmentView = Backbone.View.extend({

    initialize: function() {
    },
    
    events: {
      "click .send-button" : "makeAppointment"
    },
  
    makeAppointment: function() {
      var values = this.$el.serializeArray(), attrs = {}, me = this;
      
      _.each(values, function(kv) {
        if(kv.value.length > 0) {
          attrs[kv.name] = kv.value;
        }
      });
      
      $(".control-group", me.$el).toggleClass("error", false);
      $(".help-inline", me.$el).text("");
      
      this.model.clear();
      this.model.save(attrs, {
        error: function(model, response) {
          var errors = JSON.parse(response.responseText);
          
          _.each(_.keys(errors), function(e) {
            var field = me.$el.find("[name=" + e + "]");
            field.parents(".control-group").toggleClass("error", true);
            field.siblings(".help-inline").text(_.uniq(errors[e])[0]);
          });
        },
        
        success: function() {
          
        }
      });
    }
  });
  
  var appointment = new Appointment();
  var appointmentView = new AppointmentView({model: appointment, el: $("#appointment-request-form")});
});