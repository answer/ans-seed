# vi: set fileencoding=utf-8

require 'spec_helper'

module Ans::Seed
  module RestructSpecHelper
    module Update
      def prepare
        @keys = [:key1, :key2, :key3]
        @updates = [:update1, :update2, :update3]
        @hash = {
          key1: "KEY1",
          key2: "KEY2",
          key3: "KEY3",

          update1: "UPDATE1",
          update2: "UPDATE2",
          update3: "UPDATE3",

          column1: "COLUMN1",
          column2: "COLUMN2",
          column3: "COLUMN3",
        }

        @model = Object.new
        @entry = Object.new
        @restruct = Restruct.new @model, keys: @keys, updates: @updates

        @key = values_of @keys
        @update = values_of @updates

        stub(@model).create!(@hash)
        stub(@entry).update_attributes!(@update)
      end
      def values_of(keys)
        {}.tap{|values|
          keys.each{|key| values[key] = @hash[key]}
        }
      end

      def action_は
        @restruct.update @hash
      end

      def hash_は更新するべきカラムを一部含まない
        @not_exist_column = :update1
        @hash.delete(@not_exist_column)
      end
      def update_するときに存在しないカラムを省略する
        @update.delete(@not_exist_column)
      end

      def hash_はキーカラムを一部含まない
        @not_exist_column = :key1
        @hash.delete(@not_exist_column)
      end
      def key_で検索するときに存在しないカラムに_nil_を指定する
        @key[@not_exist_column] = nil
      end

      def model_はキーのエントリを持つ
        mock(@model)
          .where(@key).mock!
          .first{@entry}
      end
      def model_はキーのエントリを持たない
        mock(@model)
          .where(@key).mock!
          .first{nil}
      end

      def entry_の更新するべきカラムを更新する
        @entry.should have_received.update_attributes!(@update)
      end
      def model_を新規作成する
        @model.should have_received.create!(@hash)
      end
    end
  end

  describe Restruct do
    include RestructSpecHelper::Update

    before do
      prepare
    end

    context "キーからエントリが見つかる場合" do
      before do
        model_はキーのエントリを持つ
      end

      context "で、更新するべきカラムが全て提供されている場合" do
        it "は、エントリの更新するべきカラムを更新する" do
          action_は
          entry_の更新するべきカラムを更新する
        end
      end
      context "で、更新するべきカラムが一部存在しない場合" do
        before do
          hash_は更新するべきカラムを一部含まない
        end
        it "は、存在しないカラムを省略して、エントリの更新するべきカラムを更新する" do
          update_するときに存在しないカラムを省略する

          action_は
          entry_の更新するべきカラムを更新する
        end
      end
    end
    context "キーからエントリが見つからない場合" do
      before do
        model_はキーのエントリを持たない
      end
      it "は、エントリを新規作成する" do
        action_は
        model_を新規作成する
      end
    end

    context "キーカラムの一部が存在しない場合" do
      before do
        hash_はキーカラムを一部含まない
        model_はキーのエントリを持たない
      end
      it "は、存在しないキーは nil で検索され、エントリを新規作成する" do
        key_で検索するときに存在しないカラムに_nil_を指定する

        action_は
        model_を新規作成する
      end
    end
  end
end
