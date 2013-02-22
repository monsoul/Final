require 'digest/md5'


class AdminuserController < AdminController
  
  def changestatus
    @user = User.find :first, conditions: ["id = ?", params[:id]]
    @user.status == '1' ?  @user.status = 0 : @user.status = 1
    @user.save
    message = @user.status == 1 ? 'enabled' : 'disabled'
    render :json => { :result => "success", :id => params[:id], :status=>@user.status, 
                      :message => "status " + message }
  end

  def resetpassword
    @user = User.find :first, conditions: ["id = ?", params[:id]]
    @user.password = Digest::MD5.hexdigest '123456'
    @user.save
    render :json => { :result => "success",:message => @user.username + " reset password success" }
    
  
  end



  # GET /users
  # GET /users.json

#  layout 'admin'
  def index

    if request.post?
        @users = User.find :all, order: "id desc", 
          conditions: ["username like ? or real_name like ?", 
            "%"+params[:username]+"%",
          "%"+params[:username]+"%"]
        @search = true
    else
      @role = params[:role]
      if @role and @role!='all'
        @users = User.find :all, order: "id desc", conditions: ["role = ?", @role]
      else
        @users = User.find :all, order: "id desc"
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def login
    if request.post?
      account = params[:username]
      password = Digest::MD5.hexdigest params[:password]

      user = User.find(:all, :conditions => ["username=? and password=? and role='admin' ", account, password]) [0]

      if user
        session[:user_id] = user.id
        session[:username] = user.username
        redirect_to '/adminuser'
      else
        flash[:notice] = 'please check'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/adminuser'
  end


  # GET /users/1
  # GET /users/1.json
  def show
    if request.get?
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
    end
  
  end

  # GET /users/new
  # GET /users/new.json
  def new
    #@user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
#    @user = User.new(params[:user])
    @user = User.new
    @user.username = params[:username]
    @user.password = Digest::MD5.hexdigest '123456'
    @user.email = params[:email]
    @user.mobile = params[:mobile]
    @user.real_name = params[:real_name]
    @user.role = params[:role]
    @user.pic = '1.pic'
    @user.status = 1

    #respond_to do |format|
    if User.exist? @user.username
      @msg = 'username exist'
    else
      if @user.save
        @msg = 'successfully'
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render json: @user, status: :created, location: @user }
      else
        #format.html { render action: "new" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end

##codesnip  <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.0.min.js" type="text/javascript"></script>
