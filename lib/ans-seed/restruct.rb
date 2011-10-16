module Ans::Seed
  class Restruct
    def initialize(model, options)
      @model = model
      @options = options
    end

    def update(hash)
      if entry = find(hash)
        entry.update_attributes! updates_of(hash)
      else
        @model.create! hash
      end
    end

    private

    def find(hash)
      @model.where(keys_of hash).first
    end

    def keys_of(hash)
      values_of :keys, hash
    end
    def updates_of(hash)
      values_of :updates, hash, is_ignore_key_not_exist: true
    end

    def values_of(name, hash, options={})
      {}.tap{|updates|
        @options[name].each do |key|
          updates[key] = hash[key] if !options[:is_ignore_key_not_exist] || hash.key?(key)
        end
      }
    end
  end
end
