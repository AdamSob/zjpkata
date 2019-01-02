require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_q_doesnt_drop_below_0
    quality = 0
    items = [Item.new("foo", 0, quality)]
    for _ in 0..5
      GildedRose.new(items).update_quality
      assert_equal  quality, items[0].quality
    end
  end

  def test_quality_drops_by_1
    quality = 4
    items = [Item.new("foo", 5, quality)]
    gr = GildedRose.new(items)
    for i in 0..4
      assert_equal  quality-i, items[0].quality
      gr.update_quality
    end
  end

  def test_q_drops_by_2_wh_sell_in_0
    quality = 10
    items = [Item.new("foo", 0, quality)]
    gr = GildedRose.new(items)
    for i in 0..4
      assert_equal  quality-i*2, items[0].quality
      gr.update_quality
    end
  end

  def test_aged_brie_q_inc
    quality = 0
    items = [Item.new("Aged Brie", 5, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality + i, items[0].quality
      gr.update_quality
    end
  end

  def test_aged_brie_q_inc_by_2
    quality = 0
    items = [Item.new("Aged Brie", 0, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality + i*2, items[0].quality
      gr.update_quality
    end
  end

  def test_quality_lt_51
    quality = 44
    items = [Item.new("Aged Brie", 0, quality)]
    gr = GildedRose.new(items)
    for i in 0..10
      assert_equal  [quality + i*2, 50].min, items[0].quality
      gr.update_quality
    end
  end

  def test_sulfuras
    quality = [-100, 23, 100]
    items = [Item.new("Sulfuras, Hand of Ragnaros", -50, quality[0]),
             Item.new("Sulfuras, Hand of Ragnaros", 0, quality[1]),
             Item.new("Sulfuras, Hand of Ragnaros", 50, quality[2])]
    gr = GildedRose.new(items)
    for _ in 0..10
      for item_no in 0..2
        assert_equal  quality[item_no], items[item_no].quality
      end
      gr.update_quality
    end
  end

  def test_bckstg_more_than_10
    quality = 0
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality + i, items[0].quality
      gr.update_quality
    end
  end

  def test_bckstgs_less_than_11_gt_5
    quality = 0
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality + i*2, items[0].quality
      gr.update_quality
    end
  end

  def test_bckstgs_less_than_6_gt_0
    quality = 0
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality + i*3, items[0].quality
      gr.update_quality
    end
  end

  def test_bckstgs_resets_after_sell_in
    quality = 0
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      gr.update_quality
    end
    assert_equal  quality, items[0].quality
  end

  def test_conjured_before_sell_in
    quality = 10
    items = [Item.new("Conjured", 5, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality - i*2, items[0].quality
      gr.update_quality
    end
  end

  def test_conjured_after_sell_in
    quality = 30
    items = [Item.new("Conjured", 0, quality)]
    gr = GildedRose.new(items)
    for i in 0..5
      assert_equal  quality - i*4, items[0].quality
      gr.update_quality
    end
  end



end