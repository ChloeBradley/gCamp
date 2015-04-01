class WelcomeController < PublicController

  def index
    @quote= [['"gCamp has changed my life! It\'s the best tool I\'ve ever used"','-Carla Hayes'],[
    '"Before gCamp I was a disorderly slob. Now I\'m more organized than I\'ve ever been"','-Leta Jakolski'],['"Don\'t hesitate - sign up right now! You\'ll never be the same."', '-Lavern Upton']]
  end
end
