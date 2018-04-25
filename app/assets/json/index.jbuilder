json.set! 'payables.payable_items', @payable_items do | payable_item |
  # Attributes
  
  json.id payable_item.id
  json.payable_item_enhanced_description payable_item.payable_item_enhanced_description
  json.company_number payable_item.company_number
  json.item_set_id payable_item.item_set_id
  json.record_id payable_item.record_id
  json.item_document_number payable_item.item_document_number
  json.item_document_date payable_item.item_document_date
  json.item_due_date payable_item.item_due_date
  json.item_discount_date payable_item.item_discount_date
  json.item_transaction_date payable_item.item_transaction_date
  json.item_amount payable_item.item_amount
  json.item_discountable_amount payable_item.item_discountable_amount
  json.item_amount_distributed payable_item.item_amount_distributed
  json.item_discount_amount payable_item.item_discount_amount
  json.item_amount_paid payable_item.item_amount_paid
  json.item_discount_earned payable_item.item_discount_earned
  json.item_adjustment_amount payable_item.item_adjustment_amount
  json.item_balance payable_item.item_balance
  json.purchase_order_number payable_item.purchase_order_number
  json.status payable_item.status
  json.item_currency payable_item.item_currency
  json.item_exchange_rate payable_item.item_exchange_rate
  json.item_payment_priority payable_item.item_payment_priority
  json.item1099_amount_code payable_item.item1099_amount_code
  json.item1099_type payable_item.item1099_type
  json.item_reaging_date payable_item.item_reaging_date
  json.item_aging_period payable_item.item_aging_period
  json.earliest_transaction_date payable_item.earliest_transaction_date
  json.latest_transaction_date payable_item.latest_transaction_date
  json.source payable_item.source
  json.source_ref payable_item.source_ref
  json.account_number payable_item.account_number
  json.payee_account_number payable_item.payee_account_number
  json.period_closing_date payable_item.period_closing_date
  json.checking_account_code payable_item.checking_account_code
  json.terms_of_purchase_code payable_item.terms_of_purchase_code
  json.miscellaneous_address_id payable_item.miscellaneous_address_id
  json.item_entry_date payable_item.item_entry_date
  json.item_entry_time payable_item.item_entry_time
  json.item_entry_user payable_item.item_entry_user
  json.item_change_date payable_item.item_change_date
  json.item_change_time payable_item.item_change_time
  json.item_change_user payable_item.item_change_user
  json.account_enhanced_description payable_item.account_enhanced_description
  json.checking_account_enhanced_description payable_item.checking_account_enhanced_description
  json.closing_date_enhanced_description payable_item.closing_date_enhanced_description
  json.miscellaneous_address_enhanced_description payable_item.miscellaneous_address_enhanced_description
  json.payable_set_enhanced_description payable_item.payable_set_enhanced_description
  json.payee_account_enhanced_description payable_item.payee_account_enhanced_description
  json.terms_of_purchase_enhanced_description payable_item.terms_of_purchase_enhanced_description

end


if @payable_items
  json.meta do
    json.total_pages @payable_items.total_pages
    json.limit 10
    json.page params[:page]
    json.modelName 'payables.payable_item'
    json.options @options
    json.columns do
      json.array!  ['actions']  + ['account_enhanced_description'] + ['account_enhanced_description'] + ['checking_account_enhanced_description'] + ['closing_date_enhanced_description'] + ['miscellaneous_address_enhanced_description'] + ['payable_set_enhanced_description'] + ['terms_of_purchase_enhanced_description'] + @final_fields do |key|
        json.label key.humanize
        json.align 'center'
        json.valuePath key.camelcase(:lower)
        json.draggable true
        json.cellComponent 'table.cell-status' if key == 'status'
        if key == 'actions'
          json.cellComponent 'table.menu-dropdown' 
          json.width '150px'
        else
          if key.downcase.include?("description")
            json.width '200px'
          else
            json.width '80px'
          end
        end
      end
    end
  end
end

