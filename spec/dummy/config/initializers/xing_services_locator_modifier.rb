#TODO: Is this how we want to accomplish setting engine routes instead of
# application routes?
Xing::Services::Locator.module_eval do
  def router
    XingCmsBackend::Engine.routes
  end
end
