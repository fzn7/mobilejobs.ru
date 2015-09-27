class EntriesController < InheritedResources::Base

  def index
    @entries =   Entry.all.page(params[:page])
    respond_with(@entries)
  end

  private
  def entry_params
    params.require(:entry).permit()
  end
end

