# frozen_string_literal: true

RSpec.describe Karafka::Web::Management::Migrations::IntroduceLagTotalInStates do
  it { expect(described_class.versions_until).to eq('1.3.0') }
  it { expect(described_class.type).to eq(:consumers_state) }

  context 'when migrating from 1.1.0' do
    let(:state) { Fixtures.consumers_states_json('v1.1.0') }

    before { described_class.new.migrate(state) }

    it { expect(state[:stats][:lag_total]).to eq(0) }
    it { expect(state[:stats].key?(:lag)).to eq(false) }
    it { expect(state[:stats].key?(:lag_stored)).to eq(false) }
  end

  context 'when migrating from 1.2.2' do
    let(:state) { Fixtures.consumers_states_json('v1.2.2') }

    before { described_class.new.migrate(state) }

    it { expect(state[:stats][:lag_total]).to eq(0) }
    it { expect(state[:stats].key?(:lag)).to eq(false) }
    it { expect(state[:stats].key?(:lag_stored)).to eq(false) }
  end
end
