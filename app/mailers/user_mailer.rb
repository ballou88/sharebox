class UserMailer < ActionMailer::Base
  default_url_options[:host] = "sharebox.webbyapp.com"
  default :from => "sharebox@gmail.com"

  def invitation_to_share(shared_folder)
    @shared_folder = shared_folder #setting up an instance variable to be used in the email template
    mail( :to => @shared_folder.shared_email,
          :subject => "#{@shared_folder.user.name} wants to share '#{@shared_folder.folder.name}' folder with you" )
  end
end
