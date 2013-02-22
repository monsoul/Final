class AdminarticleController < AdminController

  def qa

    @qas = Qa.find :all, order: "id desc", limit: "10"
    if request.post?
      @qas = Qa.find :all, 
      conditions: ["origin_question_id is not null and (question_title like ? or content like ?)",
       "%"+params[:qa]+"%",
       "%"+params[:qa]+"%"
      ]
    end

  end

  def index
    if request.post?
      @articles = Article.find :all, 
        conditions: ["content like ? or title like ?",
         "%"+params[:article]+"%",
         "%"+params[:article]+"%"
        ]
      @search = true
    elsif params[:tag]
      @tag_id, @tag = params[:tag].split ','
      if @tag_id != 'all'
        @articles = Article.find :all, 
                conditions: ["id in (select article_id from article_tags where tag_id = ?)", @tag_id], 
                 order: "id desc", limit: "10"
      end
    else
      @articles = Article.find :all, order: "id desc", limit: "10"
    end
    @tags = Tag.find :all, order: "id desc"

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def new
    @tags = Tag.find :all, order: "id desc"
    
  end

  def create
    if params[:article][:pic]
      params[:article][:pic] = uploadFile params[:article][:pic]
    end

    @article = Article.new(params[:article])
    @article.user_id = 1
    if @article.save
      #tags
      tag_str = params[:tag].split.uniq
      tags = []

      tag_str.each{ |t|

        tag = ArticleTag.new
        tag.article_id = @article.id
        tag_name = Tag.where(["name = ?", t])
        if !tag_name.blank?
          tag.tag_id = tag_name[0].id
          tags << tag 
        end

      }


      tags.each { |t| t.save }

  		@msg = 'success ' #+ @article.id.to_s
  	end
  end

  def delete
    Article.destroy(params[:id])
    #render :json => { :result => "success",:message => "del OK "}
    redirect_to '/adminarticle'
  end

  def edit
    @tags = Tag.find :all, order: "id desc"
    @article = Article.find params[:id]
    @my_tags = ArticleTag.where(article_id: params[:id])

    @tag_str = ''
    @my_tags.each {|t| @tag_str += '  ' + Tag.find(t.tag_id).name}
  end

  def update
    @article = Article.find params[:id]
    if params[:article][:pic]
      params[:article][:pic] = uploadFile params[:article][:pic]
    end
    
    @article.user_id = 1
    if @article.update_attributes(params[:article]) #@article.save
      ArticleTag.where(["article_id = ?", params[:id]]).destroy_all
      #tags
      tag_str = params[:tag].split.uniq
      tags = []

      tag_str.each { |t|
        tag = ArticleTag.new
        tag.article_id = @article.id
        tag_name = Tag.where(["name = ?", t])
        if !tag_name.blank?
          tag.tag_id = tag_name[0].id
          tags << tag 
        end
      }
      tags.each { |t| t.save }
      @msg = 'success ' #+ @article.id.to_s
    end    
    render :create
  end

  def play
    @msg = sth
    render :create
  end

  private

  def uploadFile(file)  
    dest_dir = "#{::Rails.root}/public/upload/"
    if !Dir.exist? dest_dir
      Dir.mkdir dest_dir
    end

    if !file.original_filename.empty?  

      filename = file.original_filename
      File.open(dest_dir + filename, "wb") do |f|  
        f.write(file.read)  
      end  
      return "/upload/"+filename  
    end  
  end  


end


