class AnalysesController < ApplicationController
  def show
    @analysis = AnalysisPresenter.new(Analysis.find(params[:id]))
    render layout: 'widescreen'
  end
end