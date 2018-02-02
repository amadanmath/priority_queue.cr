require "./spec_helper"

describe PriorityQueue do
  it "can be constructed with hash-like type literal" do
    queue = PriorityQueue{
      2 => "Two",
      6 => "Six",
      3 => "Three"
    }
    queue.size.should eq 3
    queue.pop.should eq "Six"
  end

  it "removes highest-priority element" do
    queue = PriorityQueue(Int32, String).new
    queue[2] = "Two"
    queue[6] = "Six"
    queue[3] = "Three"
    queue[1] = "One"
    queue[4] = "Four"
    queue[5] = "Five"
    queue.pop.should eq "Six"
    queue.pop.should eq "Five"
    queue.pop.should eq "Four"
    queue.pop.should eq "Three"
    queue.pop.should eq "Two"
    queue.pop.should eq "One"
  end

  it "yields to block if popped when empty" do
    queue = PriorityQueue(Int32, String).new
    yielded = false
    queue.pop { yielded = true }
    yielded.should be_true
  end

  it "raises an error if popped without block when empty" do
    queue = PriorityQueue(Int32, String).new
    expect_raises(IndexError) { queue.pop }
  end
end
