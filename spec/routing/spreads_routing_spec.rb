require "spec_helper"

describe SpreadsController do
  describe "routing" do

    it "routes to #index" do
      get("/spreads").should route_to("spreads#index")
    end

    it "routes to #new" do
      get("/spreads/new").should route_to("spreads#new")
    end

    it "routes to #show" do
      get("/spreads/1").should route_to("spreads#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spreads/1/edit").should route_to("spreads#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spreads").should route_to("spreads#create")
    end

    it "routes to #update" do
      put("/spreads/1").should route_to("spreads#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spreads/1").should route_to("spreads#destroy", :id => "1")
    end

  end
end
