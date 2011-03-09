class HomeController < ApplicationController

  def index
    if user_signed_in?
      #show folder shared by others
      @being_shared_folders = current_user.shared_folders_by_others

      #load current_user's folders
      @folders = current_user.folders.roots

      #load current_user's files(assets)
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
    end
  end

  def browse
    #get the folders owned/created by the current_user
    @current_folder = current_user.folders.find_by_id(params[:folder_id])
    @is_this_folder_being_shared = false if @current_folder

    if @current_folder.nil?
      folder = Folder.find_by_id(params[:folder_id])

      @current_folder ||= folder if current_user.has_shared_access?(folder)
      @is_this_folder_being_shared = true if @current_folder
    end

    if @current_folder

      @being_shared_folders = []

      #getting the folders which are inside this @current_folder
      @folders = @current_folder.children

      #show only files under this current folder
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")

      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
  end

  def share
    email_addresses = params[:email_addresses].split(",")

    email_addresses.each do |email_address|
      @shared_folder = current_user.shared_folders.new
      @shared_folder.folder_id = params[:folder_id]
      @shared_folder.shared_email = email_address

      shared_user = User.find_by_email(email_address)
      @shared_folder.shared_user_id = shared_user.id if shared_user

      @shared_folder.message = params[:message]
      @shared_folder.save
      UserMailer.invitation_to_share(@shared_folder).deliver
    end

    respond_to do |format|
      format.js {
      }
    end
  end
end
