# Enable auto-complete and readline history in IRB
require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'

IRB.conf[:USE_READLINE] = true

IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')
IRB.conf[:EVAL_HISTORY] = 100

IRB.conf[:PROMPT][:CUSTOM] = { # name of prompt mode
  :AUTO_INDENT => true,        # enable automatic indentation
  :PROMPT_I => ">> ",          # default prompt
  :PROMPT_C => "|  ",          # continued statement
  :PROMPT_N => "|  ",          # unknown continuation
  :PROMPT_S => "%l> ",         # continued string
  :RETURN => "=> %s\n"         # printf output
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

# https://github.com/jberkel/interactive_editor
begin
  require 'interactive_editor'
rescue LoadError
  warn "Unable to load interactive_editor"
end

# https://github.com/cldwalker/hirb/
begin
  require 'hirb'
rescue LoadError
  warn "Unable to load hirb"
end

# https://github.com/awesome-print/awesome_print#irb-integration
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
  warn "Unable to load awesome_print"
end

# Rails environment
if (ENV['RAILS_ENV'] || defined? Rails) && File.exists?(irbrc_rails)
  begin
    load File.expand_path('~/.irbrc_rails')
  rescue Exception
    warn "Unable to load ~/.irbrc_rails\n#{$!.message}"
  end
end
