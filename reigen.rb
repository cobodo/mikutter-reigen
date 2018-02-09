# -*- coding: utf-8 -*-

Plugin.create(:reigen) do

  def create_body(name, uri)
    "ｽｩｯ… #{name}です… #{uri}"
  end

  compose_proc = Proc.new do |world, message|
    compose(world, body: create_body(message.user.name, message.uri))
  end

  do_nothing = Proc.new do end

  pred_true  = -> (world, message) { true }
  pred_false = -> (world, message) { false }

  defspell(:share, :worldon_for_mastodon, :twitter_tweet, condition: pred_true, &compose_proc)

  defspell(:shared, :worldon_for_mastodon, :twitter_tweet, condition: pred_false, &do_nothing)

  defspell(:share, :twitter, :worldon_status, condition: pred_true, &compose_proc)

  defspell(:shared, :twitter, :worldon_status, condition: pred_false, &do_nothing)
end
