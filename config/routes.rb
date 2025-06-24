# frozen_string_literal: true

DiscourseTermsOfUse::Engine.routes.draw do
  get "/" => "terms#show"
  post "/accept" => "terms#accept"
end

Discourse::Application.routes.draw do
  mount ::DiscourseTermsOfUse::Engine, at: "terms-of-use"
end
