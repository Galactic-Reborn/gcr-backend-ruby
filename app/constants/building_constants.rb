# frozen_string_literal: true

module BuildingConstants
  BUILDINGS_ID = {
    titanium_foundry: 100,
    auronium_synthesizer: 101,
    hydrogen_extractor: 102,
    solar_array: 103,
    fusion_power_plant: 104,
    lunar_mine: 105,
    advanced_research_institute: 106,
    aerospace_yard: 107,
    geomorphological_reshaper: 108,
    robotics_workshop: 109,
    nano_assembly_factory: 110,
    auronium_repository: 111,
    hydrogen_tank: 112,
    titanium_depot: 113,
    star_ship_hangar: 114,
    missile_silo: 115,
  }.freeze

  BUILDINGS_NAME = {
    100 => 'titanium_foundry',
    101 => 'auronium_synthesizer',
    102 => 'hydrogen_extractor',
    103 => 'solar_array',
    104 => 'fusion_power_plant',
    105 => 'lunar_mine',
    106 => 'advanced_research_institute',
    107 => 'aerospace_yard',
    108 => 'geomorphological_reshaper',
    109 => 'robotics_workshop',
    110 => 'nano_assembly_factory',
    111 => 'auronium_repository',
    112 => 'hydrogen_tank',
    113 => 'titanium_depot',
    114 => 'star_ship_hangar',
    115 => 'missile_silo',
  }.freeze

  BUILDINGS_COSTS = {
    100 => {
      titanium: 60,
      auronium: 15,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    101 => {
      titanium: 48,
      auronium: 24,
      hydrogen: 0,
      energy: 0,
      factor: 1.6,
    },
    102 => {
      titanium: 225,
      auronium: 75,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    103 => {
      titanium: 75,
      auronium: 30,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    104 => {
      titanium: 900,
      auronium: 360,
      hydrogen: 180,
      energy: 0,
      factor: 1.8,
    },
    105 => {
      titanium: 450,
      auronium: 900,
      hydrogen: 0,
      energy: 0,
      factor: 1.8,
    },
    106 => {
      titanium: 200,
      auronium: 400,
      hydrogen: 200,
      energy: 0,
      factor: 2,
    },
    107 => {
      titanium: 20000,
      auronium: 40000,
      hydrogen: 0,
      energy: 0,
      factor: 2,
    },
    108 => {
      titanium: 0,
      auronium: 50000,
      hydrogen: 100000,
      energy: 0,
      factor: 2,
    },
    109 => {
      titanium: 400,
      auronium: 120,
      hydrogen: 200,
      energy: 0,
      factor: 2,
    },
    110 => {
      titanium: 1000000,
      auronium: 500000,
      hydrogen: 100000,
      energy: 0,
      factor: 2,
    },
    111 => {
      titanium: 1000,
      auronium: 500,
      hydrogen: 0,
      energy: 0,
      factor: 2,
    },
    112 => {
      titanium: 1000,
      auronium: 1000,
      hydrogen: 0,
      energy: 0,
      factor: 2,
    },
    113 => {
      titanium: 1000,
      auronium: 0,
      hydrogen: 0,
      energy: 0,
      factor: 2,
    },
    114 => {
      titanium: 400,
      auronium: 200,
      hydrogen: 100,
      energy: 0,
      factor: 2,
    },
    115 => {
      titanium: 20000,
      auronium: 20000,
      hydrogen: 1000,
      energy: 0,
      factor: 2,
    },
  }.freeze

  # TODO - Add buildings requirements

  BUILDINGS_REQUIREMENTS = {

  }.freeze
end
