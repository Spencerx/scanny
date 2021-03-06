require "spec_helper"

module Scanny::Checks
  describe BackticksCheck do
    before :each do
      @runner = Scanny::Runner.new(BackticksCheck.new)
      @issue = issue(:high,
        "Backticks and %x{...} pass the executed command through shell expansion.",
        [88, 78])
    end

    it "reports backticks correctly" do
      @runner.should check('`ls -l`').with_issue(@issue)
      @runner.should check('`ls #{options}`').with_issue(@issue)
    end

    it "reports %x{...} correctly" do
      @runner.should check('%x{ls -l}').with_issue(@issue)
      @runner.should check('%x{ls #{options}}').with_issue(@issue)
    end
  end
end
