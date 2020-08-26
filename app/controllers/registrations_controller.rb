class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    # '/an/example/path' # Or :prefix_to_your_route
    new_artist_path
  end
end
