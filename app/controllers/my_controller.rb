class MyController < ApplicationController
  layout 'common'

  def works
    user = User.find(session[:user_id])
    @works = user.works.search :page =>  params[:page]
  end

  def groups_works
    user = User.find(session[:user_id])
    @works = user.groups_works :page => params[:page]
  end

  def create_missed_works
    works_count = Task.create_missed_works
    render :text => "#{works_count} works was created"
  end

  def close_works
    works_count = 0
    Work.find(:all, :conditions => ["created_at < ? and ( status = 1 or status = 2 or status = 3)", Time.today]).each do |work|
      work.auto_close( 1 )
      works_count += 1
    end
    render :text => "#{works_count} works was updated"
  end
end
