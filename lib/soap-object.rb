require 'savon'
require 'soap-object/version'
require 'soap-object/class_methods'

module SoapObject
  attr_reader :wsdl

  def initialize
    @client = Savon.client(with_wsdl) if wsdl?
    @client = Savon.client(with_endpoint.merge(with_namespace)) if endpoint?
  end

  def self.included(cls)
    cls.extend SoapObject::ClassMethods
  end

  def connected?
    not @client.nil?
  end

  def operations
    @client.operations if wsdl?
  end

  private

  def wsdl?
    respond_to? :with_wsdl
  end

  def endpoint?
    respond_to? :with_endpoint and respond_to? :with_namespace
  end
  
end