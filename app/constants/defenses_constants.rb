# frozen_string_literal: true

module DefensesConstants
  DEFENSES_ID = {
    orbital_artillery: 200,
    radiant_cannon: 201,
    sunstrike_blaster: 202,
    electromagnetic_railgun: 203,
    ion_cannon: 204,
    plasma_turret: 205,
    titan_dome: 206,
  }.freeze

  DEFENSES_NAME = {
    200 => 'orbital_artillery',
    201 => 'radiant_cannon',
    202 => 'sunstrike_blaster',
    203 => 'electromagnetic_railgun',
    204 => 'ion_cannon',
    205 => 'plasma_turret',
    206 => 'titan_dome',
  }.freeze

  DEFENSES_COSTS = {
    200 => {
      titanium: 1500,
      auronium: 10,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    201 => {
      titanium: 2000,
      auronium: 1000,
      hydrogen: 0,
      energy: 0,
      factor: 1.6,
    },
    202 => {
      titanium: 5000,
      auronium: 2500,
      hydrogen: 0,
      energy: 0,
      factor: 1.7,
    },
    203 => {
      titanium: 25000,
      auronium: 15000,
      hydrogen: 1000,
      energy: 0,
      factor: 1.8,
    },
    204 => {
      titanium: 5000,
      auronium: 2000,
      hydrogen: 0,
      energy: 0,
      factor: 1.9,
    },
    205 => {
      titanium: 40000,
      auronium: 45000,
      hydrogen: 25000,
      energy: 0,
      factor: 2.0,
    },
    206 => {
      titanium: 40000,
      auronium: 30000,
      hydrogen: 0,
      energy: 0,
      factor: 2.1,
    },
  }.freeze

  # TODO: Add stats for defenses
  # TODO: Add requirements for defenses

  DEFENSES_STATS = {

  }.freeze

  DEFENSES_REQUIREMENTS = {

  }.freeze
end
