require "./priority_queue/*"

# TODO: Write documentation for `PriorityQueue`
class PriorityQueue(P, T)
  class Element(P, T)
    include Comparable(Element)

    getter priority : P
    getter item : T

    def initialize(@priority : P, @item : T)
    end

    def <=>(other : Element)
      priority <=> other.priority
    end
  end


  getter elements = [] of Element(P, T)

  def pop
    if @elements.size == 0
      yield
    else
      exchange(0, @elements.size - 1)
      max = @elements.pop
      bubble_down(0)
      max.item
    end
  end

  def pop
    pop { raise IndexError.new }
  end

  def size
    @elements.size
  end

  def []=(priority, object)
    @elements << Element.new(priority, object)
    bubble_up(@elements.size - 1)
  end

  private def bubble_up(index)
    return if index == 0

    parent_index = (index - 1) / 2
    return if @elements[parent_index] >= @elements[index]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  private def bubble_down(index)
    child_index = index * 2 + 1
    return if child_index >= @elements.size

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]

    child_index += 1 if not_the_last_element && @elements[child_index + 1] > left_element
    return if @elements[index] >= @elements[child_index]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  private def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end
end
