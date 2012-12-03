class EventMailer < ActionMailer::Base
  def new_event_notify(user, evento)
      @evento = evento  
      mail(:to => user.email, :subject => "New Event", :from => "no-reply@concerts_share.com")    
  end  
end