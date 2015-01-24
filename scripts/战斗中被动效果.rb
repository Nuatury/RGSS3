#===============================================================================
# ■ 战斗中自动附加被动状态
# By ：VIPArcher
#  -- 本脚本来自 http://rm.66rpg.com 使用或转载请保留以上信息。
#==============================================================================
# ■ 在战斗开始时自动为每一位战斗者附加上设置好的状态，战斗结束时移除
# 使用说明：
#   在角色|职业|装备|敌人的备注栏备注<被动状态:状态ID> 例如 <被动状态:18> 
#   同时备注多个被动状态亦可叠加，都会为其附加上对应的状态。只有战斗开始时附加一次状态
#   的备注栏应该也可以用，只要战斗开始前有某状态亦可附加上该状态备注栏里指定对的状态
#==============================================================================
$VIPArcherScript ||= {};$VIPArcherScript[:battle_state] = 20141102
#--------------------------------------------------------------------------------
class Game_Battler < Game_BattlerBase
  #--------------------------------------------------------------------------
  # ● 战斗开始处理
  #--------------------------------------------------------------------------
  alias state_battle_start on_battle_start
  def on_battle_start
    state_battle_start
    self.feature_objects.each {|obj| obj.note.split(/[\r\n]+/).each{ |line|
    self.add_state($1.to_i) if line =~ /<被动状态:\s*(\d+)>/}}
  end
  #--------------------------------------------------------------------------
  # ● 战斗结束处理
  #--------------------------------------------------------------------------
  alias state_on_battle_end on_battle_end
  def on_battle_end
    state_on_battle_end
    self.feature_objects.each {|obj| obj.note.split(/[\r\n]+/).each{ |line|
    self.remove_state($1.to_i) if line =~ /<被动状态:\s*(\d+)>/}}
  end
end