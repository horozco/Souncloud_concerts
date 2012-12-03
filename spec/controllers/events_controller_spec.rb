require "spec_helper"

describe EventsController do
  
  context "All user" do
    it "Should can view with a list of the all concerts at index" do
      4.times {create(:event)}
      get :index
      assigns[:events].should have_at_least(4).events
      response.should render_template(:index)     
    end

    it "Should view all the information of a specific concert" do
      existing_event = create(:event)
      get :show, id: existing_event.id
      assigns[:event].should == existing_event
      response.should render_template(:show)     
    end

  end

  context "A not logged in user should be redirec to to the sing in page when" do
    it "trying go to the new event page " do
      get :new
      response.should_not be_success
    end

    it "submitting form on new post page" do
      get :create
      response.should_not be_success
    end

     it "trying go to the edit event page " do
      get :edit, id: create(:event).id
      response.should_not be_success
    end

    it "trying to submit an update for an existing event. The event shouldn't be changed" do
      existing_event = create(:event)
      put :update, {
        id: existing_event.id,
        event: { date: "date changed" }
      }
      existing_event.reload.date.should_not eql("date changed")
      response.should_not be_success
    end
  end

  context "A logged in user " do
    login_user

    it "should be able to see the new event page" do
      get :new
      response.should render_template(:new)
    end

    it "should be able to create a new event and be redirected to such event page with a flash notice message" do
      expect {
        post :create, {:event => attributes_for(:event)}
        created_event = assigns[:event]
        #ya se guardó
        created_event.should_not be_new_record
        response.should redirect_to(event_path(created_event))
        created_event.user.should eql(subject.current_user)
        flash[:notice].should_not be_nil
      }.to change { Event.count }.by(1)
    end

    it "shouldn't be able to create an invalid event.  Should be instead redirected to the new event page with a flash error message" do
      expect {
        post :create, {:event => attributes_for(:invalid_event)}
        created_event = assigns[:event]
        #no se ha guardado
        created_event.should be_new_record
        response.should render_template(:new)
        flash[:error].should_not be_nil
      }.to change { Event.count }.by(0)
    end

    context "if is the owner of the event" do 

      it "sholud go to the edit event page" do
        existing_event = create(:event, {user: subject.current_user})  
        get :edit, id: existing_event.id
        response.should render_template(:edit)
      end

      it "should be able to submit an update for an existing event. The event should be changed and the user redirected to the show page with a flash notice message" do
        existing_event = create(:event, {user: subject.current_user})
        put :update, {
          id: existing_event.id,
          event: { date: "Date changed" }
        }
        existing_event.reload.date.should eql("Date changed")
        flash[:notice].should_not be_nil
        response.should redirect_to(event_path(existing_event))
      end

      it "shouldn't be able to update an existing event with invalid values.  Should be presented with the same edit page and a flash error message" do
        existing_event = create(:event, {user: subject.current_user})
        put :update, {
          id: existing_event.id,
          event: { full_description: "" }
        }
        existing_event.reload.full_description.should_not eql("")
        flash[:error].should_not be_nil
        response.should render_template(:edit)
      end

      it "should be able to delete an existing event. The user redirected to the events page with a flash notice message" do
        post :create, {:event => attributes_for(:event)}
        created_event = assigns[:event]
        expect {
        delete :destroy,id: created_event.id        
        }.to change { Event.count }.by(-1)
        response.should redirect_to(events_url)
        flash[:notice].should_not be_nil 
      end      
    end
  end
end