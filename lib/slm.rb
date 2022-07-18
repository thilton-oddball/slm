# frozen_string_literal: true

require 'slm'
require_relative 'slm/version'
require 'thor'
require 'json'

module Slm
  class Error < StandardError; end
  class CLI < Thor
    ALLOWED = ['add_song_to_playlist', 'add_new_playlist', 'remove_playlist']

    desc 'process', 'Reads in the source and changes files and creates new output file'
    method_option :base, aliases: '-b', type: :string, desc: 'Will prepend basepath to filenames'
    def process(source, changes, output)
      # read in source file and parse it
      source = File.join("#{options[:base]}", source) if options[:base]
      source_file = File.read(source)
      @source = JSON.parse(source_file)
  
      # read in changes file and parse it
      changes = File.join("#{options[:base]}", changes) if options[:base]
      changes_file = File.read(changes)
      changes_array = JSON.parse(changes_file)

      # loop through changes array and call methods based on the action
      changes_array['playlists'].each do |list|
        send(list['action'],list) if ALLOWED.include?(list['action'])
      end

      # create output file
      output = File.join("#{options[:base]}", output) if options[:base]
      File.write(output, JSON.pretty_generate(@source, {space_before: ' '}))
    end

    protected

    def add_song_to_playlist(list)
      # find the playlist in the source and merge in the song_ids
      @source['playlists'].find { |p| p['id'] == list['id'] }['song_ids']&.concat(list['song_ids'])
    end

    def add_new_playlist(list)
      # make sure the playlist has at least one song
      return unless list['song_ids']&.any?

      # determine the new playlist id based on the current largest id
      new_id = @source['playlists'].sort_by { |p| p['id'] }.last['id'].to_i + 1

      # add new id to a new hash
      new_playlist = {}
      new_playlist['id'] = new_id.to_s 

      # delete action key and merge list into new hash
      list.delete('action')
      new_playlist.merge!(list)

      # add new playlist to array
      @source['playlists'] << new_playlist
    end

    def remove_playlist(list)
      # delete playlist based on the id
      @source['playlists'].delete_at(@source['playlists'].index(@source['playlists'].find{ |p| p['id'] == list['id'] }))
    end
  end
end
