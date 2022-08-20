require_relative '../lib/library'
require_relative './support/board_state_helper'

describe RookValidation do
  describe '#piece_move_valid?' do
    context 'when moving horizontally over empty squares' do
      it 'returns true'
    end
    context 'when moving horizontally over occupied squares' do
      it 'returns false'
    end
    context 'when moving vertically over empty squares' do
      it 'returns true'
    end
    context 'when moving horizontally over occupied squares' do
      it 'returns false'
    end
  end
end
