require_dependency "crossapp/application_controller"
require 'xmladapter'

module Crossapp
  class Api::V1::AccountContactsController < ApplicationController
    
    #before_action :find_account
    

    def index
    
      if params[:parent].present?
    
        @account_contacts = Crossapp.const_get(params[:parent].underscore.classify).find_by_keys(params[:parent_id]).account_contacts.page(params[:page])
        @account_contacts = @account_contacts.order(Hash[params[:sort].underscore, params[:dir].to_sym]) if params[:sort].present? && params[:dir].present?
        sorted_fields = current_user.field_orders.try(:[], 'crossapp.account-contact')
        if sorted_fields
          @final_fields = (sorted_fields + Crossapp::AccountContact.attribute_aliases.keys).uniq
        end
        @final_fields ||= Crossapp::AccountContact.attribute_aliases.keys
    
      end
    
      @options = build_options
    end

    def update
      
      @account_contact = AccountContact.find_by_keys(params[:id])
      if @account_contact.update_attributes account_contact_params
        @options = build_options
        @read_only_fields = Account.read_only_fields
        render
      else
        render json: { errors: @account_contact .errors.to_h }, status: 422
      end

    end

    def destroy
      # destroy code goes here
    end

    def show
      @account_contact = AccountContact.find_by_keys params[:id]
      @options = build_options
      @read_only_fields = AccountContact.read_only_fields
    end

    def execute_action
      
      account_number = params[:account_number]
      record_id = params[:record_id]
      native_program = params[:native_program]
      return_code = ''
      Crossapp::XMLAdapter.new(native_program, [{type: 'I_a', args: ['return_code', '7', return_code]}, {type: 'I_DS', args: ['params', 1, [
                    XMLService::I_a.new('account_number',10, account_number),
                    XMLService::I_a.new('record_id',9,0, record_id)
                    ]]}])
      @account_contact = AccountContact.find_by_keys(params[:account_contact_id])
      render :update
    end


    private

    def account_contact_params
      params.require('crossapp.account_contact').permit(:account_number, :record_id, :name, :account_phone_number, :account_fax_number, :account_email, :account_website, :contact_description)
    end

    
#    def find_account
#      @account = Crossapp::Account.find_by_keys(params[:account_id]) if params(account_id).present?
#    end
    


    def build_options
      # options for this object:
      
      options = []
        options << {text: 'Build Acct Soundex Codes', route: 'accountBuildAcctSoundexCodes', url: "crossapp/api/v1/accounts/:id/execute_action", params: [{number: 'number'}, {native_program: 'XAILXFR'}]} if authenticate_option('Account: Build Acct Soundex Codes XAILXFR')
        options << {text: 'Delete Account', route: 'accountDeleteAccount', url: "crossapp/api/v1/accounts/:id/execute_action", params: [{number: 'number'}, {native_program: 'XAINXFR'}]} if authenticate_option('Account: Delete Account XAINXFR')
      options
    end


  end
end
