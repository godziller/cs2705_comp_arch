<map version="freeplane 1.9.13">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="Branching" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1730562273290" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" fit_to_viewport="false" associatedTemplateLocation="template:/standard-1.6.mm"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_271890427" ICON_SIZE="12 pt" COLOR="#000000" STYLE="fork">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="200" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_271890427" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
<richcontent CONTENT-TYPE="plain/auto" TYPE="DETAILS"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" BACKGROUND_COLOR="#afd3f7" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#afd3f7"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_67550811">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#003399" TRANSPARENCY="255" DESTINATION="ID_67550811"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="6" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Controlls Flow of code - if/then/else/while" POSITION="right" ID="ID_446785334" CREATED="1730562277583" MODIFIED="1730562294748">
<edge COLOR="#ff0000"/>
</node>
<node TEXT="Conditional Branching" POSITION="left" ID="ID_1553922122" CREATED="1730562303765" MODIFIED="1730562323413">
<edge COLOR="#0000ff"/>
<node TEXT="This is the typical If checks, including Loops" ID="ID_56481529" CREATED="1730562379165" MODIFIED="1730562398989">
<node TEXT="beq, bne,&#xa;bgtz, bltz, bgez&#xa;blez" ID="ID_50314934" CREATED="1730562473391" MODIFIED="1730562500863"/>
</node>
<node TEXT="blt is not a core/basic MIPS instruction" ID="ID_1382285665" CREATED="1730562725290" MODIFIED="1730562739052">
<node TEXT="too complicated" ID="ID_1798905576" CREATED="1730562741635" MODIFIED="1730562750895"/>
<node TEXT="Solution - use 2 basic instructions instead:&#xa;slt rd, rs, rt&#xa;bne rd, 0" ID="ID_1718241747" CREATED="1730562758540" MODIFIED="1730562794258"/>
</node>
</node>
<node TEXT="Changes the value of the Program Counter (PC)" POSITION="right" ID="ID_925605532" CREATED="1730562327222" MODIFIED="1730562352191">
<edge COLOR="#00ff00"/>
</node>
<node TEXT="Unconditional Branching" POSITION="left" ID="ID_1434061685" CREATED="1730562362097" MODIFIED="1730562370093">
<edge COLOR="#ff00ff"/>
<node TEXT="These are the jump cases" ID="ID_338093203" CREATED="1730562402918" MODIFIED="1730562422124">
<node TEXT="J [label]&#xa;jal [Call: Label]&#xa;jr - return from call" ID="ID_790952737" CREATED="1730562425241" MODIFIED="1730562471381"/>
</node>
<node TEXT="Only use J in a if loop" ID="ID_1096857443" CREATED="1730562642963" MODIFIED="1730562655686"/>
</node>
<node TEXT="Where to jump to?" POSITION="right" ID="ID_1133640039" CREATED="1730562544570" MODIFIED="1730562551605">
<edge COLOR="#00ffff"/>
<node TEXT="calculated" ID="ID_981423345" CREATED="1730562551984" MODIFIED="1730562571250"/>
<node TEXT="no of instructions from current PC+4" ID="ID_1609517716" CREATED="1730562571615" MODIFIED="1730562608012"/>
</node>
<node TEXT="SHIFTING" POSITION="left" ID="ID_1243174132" CREATED="1730562874635" MODIFIED="1730562882393">
<edge COLOR="#7c0000"/>
<node TEXT="shift left same as multiply by 2" ID="ID_1025727369" CREATED="1730562893747" MODIFIED="1730562904344"/>
<node TEXT="shift right is dividing by 2" ID="ID_1146624332" CREATED="1730562905893" MODIFIED="1730562922079"/>
</node>
</node>
</map>
