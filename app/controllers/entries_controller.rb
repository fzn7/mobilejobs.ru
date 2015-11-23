class EntriesController < ActionController::Base

  def index
    @entries =   Entry.all_sorted.page(params[:page])
    respond_with(@entries)
  end

  private
  def entry_params
    params.require(:entry).permit()
  end
end

