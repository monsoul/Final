class AdmintagController < AdminController
#  layout "admin"

  def index
  	@tags = Tag.find :all, order: 'id desc'
  end

  def new
    @user = User.new
  end

  def create
#  	flash[:notice] = 'tag created'
    tag = Tag.new
    tag.name = params[:name]
    tag.save
    redirect_to '/admintag'
  end

end
