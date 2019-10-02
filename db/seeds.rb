TOURNAMENT_TEAMS_COUNT = 16
DIVISION_TEAMS_COUNT = 8

ActiveRecord::Base.transaction do

  tournaments = [
      'UEFA Super Cup',
      'UEFA Nations League',
      'UEFA European Championship'

  ].map { |tournament_name| Tournament.create(title: tournament_name) }

  teams = [
      'Ajax (NED)',
      'Atalanta (ITA)',
      'Barcelona (ESP)',
      'Benfica (POR)',
      'Chelsea (ENG)',
      'Club Brugge (BEL)',
      'Dinamo Zagreb (CRO)',
      'Dortmund (GER)',
      'Galatasaray (TUR)',
      'Genk (BEL)',
      'Internazionale (ITA)',
      'Juventus (ITA)',
      'Liverpool (ENG)',
      'Lokomotiv Moskva (RUS)',
      'Man. City (ENG)',
      'Napoli (ITA)',
      'Olympiacos (GRE)',
      'Paris (FRA)',
      'Real Madrid (ESP)',
      'Salzburg (AUT)',
      'Shakhtar Donetsk (UKR)',
      'Tottenham (ENG)',
      'Valencia (ESP)',
      'Zenit (RUS)'

  ].map { |team_name| Team.create(name: team_name) }

  tournaments.each do |tournament|
    tournament.teams = teams.shuffle.take(TOURNAMENT_TEAMS_COUNT)
    division_a_teams, division_b_teams = tournament.teams.each_slice(DIVISION_TEAMS_COUNT).to_a

    division_a = Group::Division.create(
      title: 'Division A',
      tournament: tournament,
      teams: division_a_teams
    )

    division_b = Group::Division.create(
      title: 'Division B',
      tournament: tournament,
      teams: division_b_teams
    )

    tournament.save
  end
end
