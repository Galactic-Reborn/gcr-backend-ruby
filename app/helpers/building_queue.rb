class BuildingQueue
  attr_accessor :queue

  def initialize(queue)
    @queue = queue['queue']
  end

  def get_queue
    @queue
  end

  def set_queue(queue)
    @queue = queue
  end

  def add_queue_item(queue_item)
    @queue.push(queue_item)
  end

  def remove_queue_item
    @queue.shift
  end

  def get_first_queue_item
    @queue.first
  end

  def get_last_queue_item
    @queue.last
  end

  def get_length
    @queue.length
  end

  def get_count_by_unit_id(unit_id)
    @queue.count { |queue_item| queue_item['unit_id'] == unit_id }
  end

  def get_queue_item_by_unit_id(unit_id)
    @queue.find { |queue_item| queue_item['unit_id'] == unit_id }
  end

  def remove_queue_item_by_unit_id(unit_id)
    @queue.reverse_each do |queue_item|
      if queue_item['unit_id'] == unit_id
        @queue.delete(queue_item)
        break
      end
    end
  end

  def get_queue_in_json
    @queue.to_json
  end
end
