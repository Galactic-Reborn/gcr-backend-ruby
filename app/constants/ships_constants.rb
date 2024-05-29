# frozen_string_literal: true

module ShipsConstants
  SHIPS_ID = {
    swift_striker: 300,
    thunderbird: 301,
    sky_guardian: 302,
    stellar_sentinel: 303,
    void_vanguard: 304,
    war_mammoth: 305,
    dreadnought: 306,
    micro_hauler: 307,
    leviathan_loader: 308,
    prospector: 309,
    salvager: 310,
    conquestor: 311,
  }.freeze

  SHIPS_NAME = {
    300 => 'swift_striker',
    301 => 'thunderbird',
    302 => 'sky_guardian',
    303 => 'stellar_sentinel',
    304 => 'void_vanguard',
    305 => 'war_mammoth',
    306 => 'dreadnought',
    307 => 'micro_hauler',
    308 => 'leviathan_loader',
    309 => 'prospector',
    310 => 'salvager',
    311 => 'conquestor',
  }.freeze

  SHIPS_COSTS = {
    300 => {
      titanium: 3000,
      auronium: 1000,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    301 => {
      titanium: 6000,
      auronium: 4000,
      hydrogen: 0,
      energy: 0,
      factor: 1.6,
    },
    302 => {
      titanium: 20000,
      auronium: 7000,
      hydrogen: 2000,
      energy: 0,
      factor: 1.7,
    },
    303 => {
      titanium: 30000,
      auronium: 40000,
      hydrogen: 15000,
      energy: 0,
      factor: 1.8,
    },
    304 => {
      titanium: 50000,
      auronium: 25000,
      hydrogen: 15000,
      energy: 0,
      factor: 1.9,
    },
    305 => {
      titanium: 60000,
      auronium: 50000,
      hydrogen: 15000,
      energy: 0,
      factor: 2,
    },
    306 => {
      titanium: 1000000,
      auronium: 500000,
      hydrogen: 250000,
      energy: 0,
      factor: 2.1,
    },
    307 => {
      titanium: 2000,
      auronium: 2000,
      hydrogen: 0,
      energy: 0,
      factor: 1.5,
    },
    308 => {
      titanium: 6000,
      auronium: 6000,
      hydrogen: 0,
      energy: 0,
      factor: 1.6,
    },
    309 => {
      titanium: 1000,
      auronium: 500,
      hydrogen: 0,
      energy: 0,
      factor: 1.7,
    },
    310 => {
      titanium: 10000,
      auronium: 5000,
      hydrogen: 1500,
      energy: 0,
      factor: 1.8,
    },
    311 => {
      titanium: 15000,
      auronium: 12500,
      hydrogen: 10000,
      energy: 0,
      factor: 1.9,
    },
  }.freeze

  # TODO: Add stats for ships
  # TODO: Add requirements for ships

  SHIPS_STATS = {

  }.freeze

  SHIPS_REQUIREMENTS = {

  }.freeze
end


