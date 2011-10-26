/* DO NOT MODIFY. This file was compiled Tue, 25 Oct 2011 00:40:33 GMT from
 * /home/lee/Dropbox/works/rails/bettatest/app/coffeescripts/edit_subscription.coffee
 */

(function() {
  var subscription;
  jQuery(function() {
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    return subscription.setupForm();
  });
  subscription = {
    setupForm: function() {
      return $('.edit_subscription').submit(function() {
        $('input[type=submit]').attr('disabled', true);
        if ($('#card_number').length) {
          subscription.processCard();
          return false;
        } else {
          return true;
        }
      });
    },
    processCard: function() {
      var card;
      card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val()
      };
      return Stripe.createToken(card, subscription.handleStripeResponse);
    },
    handleStripeResponse: function(status, response) {
      if (status === 200) {
        $('#subscription_stripe_card_token').val(response.id);
        return $('.edit_subscription')[0].submit();
      } else {
        $('#stripe_error').text(response.error.message);
        return $('input[type=submit]').attr('disabled', false);
      }
    }
  };
}).call(this);
