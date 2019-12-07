
  //--- Get #shipping_company for MailImageRequest --------------------------------------------
  function completeForwardRequest(url, shipping_company, box){
    $.ajax({
      url: url.replace('slug_for_shipping_company', shipping_company),
      method: 'POST',
      dataType: 'script',
      format: 'script',
      complete: function(){
        box.closest('.controls').detach();
      }
    });
  }

  function getOtherShippingCompanyToCompleteForwardRequest(url, box){
    var input = $('<input name="other_shipping_company" class="form-control" placeholder="Name of other Company" />');
    box.html(input);
    input.change(function(e){
      completeForwardRequest(url, $(this).val(), box);
    });
    input.select();
  }

  function initForwardRequests(){
    var forward_requests = $('.forward_request_link');
    forward_requests.each(function(i, req){
      $(this).on('click', function(e){
        e.preventDefault();
        e.stopImmediatePropagation();

        // Get relevant data from the link
        var link = $(this);
        var url = link.attr('href');
        var box = link.closest('.form-group');

        // Create a Select for possible mailing options
        var select = $('<select name="shipping_company" class="form-control select_with_sections  "></select>');
        select.append('<option>Select a Shipping Option</option>');

        var options = [
          ['2 or 3 Business Day Delivery', false],
          ['FedEx 2 Day AM', true],
          ['FedEx 2 Day', true],
          ['FedEx Saver 3 Day', true],
          ['Ground Delivery', false],
          ['FedEx Business Ground', true],
          ['FedEx Home Ground', true],
          ['FedEx SmartPost', true],
          ['Same Day Delivery', false],
          ['FedEx Same Day National', true],
          ['FedEx Same Day City', true],
          ['Next Day Delivery', false],
          ['FedEx First Overnight', true],
          ['FedEx Priority Overnight', true],
          ['FedEx Standard Overnight', true],
          ['2 to 3 Day Business Delivery', false],
          ['FedEx 2 Day', true]
        ]

        $.each(options, function(i, option){
          var option_tag = $('<option name="' + option[0] + '">' + option[0] + '</option>');
          if(!option[1]){
            option_tag.attr('disabled', 'disabled');
          }

          select.append(option_tag);
        });

        box.html(select);

        select.change(function(e){
          // On change, either send the request, or get the name of the 'Other' shipping co
          var co = $(this).val();
          if(co == 'Other'){
            getOtherShippingCompanyToCompleteForwardRequest(url, box);
          } else {
            completeForwardRequest(url, co, box);
          }

        });
      });
    });
  }
