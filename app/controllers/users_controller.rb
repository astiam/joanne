class UsersController < ApplicationController
    def index
        @patients = Patient.all
    end
end
