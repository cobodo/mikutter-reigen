# -*- coding: utf-8 -*-

Plugin.create(:reigen) do

  defspell(:share, :worldon_for_mastodon, :twitter_tweet,
           condition: -> (world, message) { true }
          ) do |world, message|
    body = "ｽｩｯ…#{message.user.name}です…\n#{message.uri}"
    compose(world, body: body)
  end

  defspell(:shared, :worldon_for_mastodon, :twitter_tweet,
           condition: -> (world, message) { false }
          ) do |world, message| end

  defspell(:share, :twitter, :worldon_status,
           condition: -> (twitter, status) { true }
          ) do |twitter, status|
    body = "ｽｩｯ…#{status.account.display_name}です…\n#{status.url}"
    compose(twitter, body: body)
  end

  defspell(:shared, :twitter, :worldon_status,
           condition: -> (twitter, status) { false }
          ) do |twitter, status| end

end
