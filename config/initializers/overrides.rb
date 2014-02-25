# Overrides devise flash messages for twitter boostrap
module DeviseControllerFlashMessage
  # This method is called when this mixin is included
  def self.included klass
    # klass here is our DeviseController

    klass.class_eval do
      remove_method :set_flash_message
    end
  end

  protected 
  def set_flash_message(key, kind, options = {})
    if key == 'alert'
      key = 'error'
    elsif key == 'notice'
      key = 'success'
    end
    message = find_message(kind, options)
    flash[key] = message if message.present?
  end
end

DeviseController.send(:include, DeviseControllerFlashMessage)