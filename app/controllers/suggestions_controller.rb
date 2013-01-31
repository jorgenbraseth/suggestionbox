class SuggestionsController < ApplicationController
  # GET /suggestions
  # GET /suggestions.json
  def index
    @who_am_i = ip

    @suggestions = Suggestion.all
    @categories_from_suggestions = @suggestions.group_by(&:category)
    @categories_from_suggestions.each {|k,v| @categories_from_suggestions[k]=v.size if v}
    @categories_from_suggestions = @categories_from_suggestions.sort_by {|k,v| -v}

    respond_to do |format|
      format.html { render :template => "suggestions/index"}
      format.json { render json: @categories_from_suggestions }
    end
  end

  def category_index
    @who_am_i = ip

    @category = params[:category]
    @suggestions = Suggestion.where("category = ?",@category).order("suggestion_votes_count desc")

    respond_to do |format|
      format.html
      format.json { render json: @suggestions }
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/new
  # GET /suggestions/new.json
  def new
    @suggestion = Suggestion.new
    @suggestion.category = params[:category]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/1/edit
  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def vote
    @suggestion = Suggestion.find(params[:id])

    @suggestion.vote!(ip)
    respond_to do |format|
      format.html { redirect_to category_path(@suggestion.category) }
      format.json { render json: Suggestion.find(params[:id]) }
    end

  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(params[:suggestion])

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to category_path(@suggestion.category), notice: 'Suggestion was successfully created.' }
        format.json { render json: @suggestion, status: :created, location: @suggestion }
      else
        format.html { redirect_to category_path(@suggestion.category), notice: 'No suggestion created' }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suggestions/1
  # PUT /suggestions/1.json
  def update
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to category_path(@suggestion.category) }
      format.json { head :no_content }
    end
  end

  private

  def ip() request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip end
end
