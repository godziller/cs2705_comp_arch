<map version="freeplane 1.9.13">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="Design Principals" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1730564162815" STYLE="oval">
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
<hook NAME="AutomaticEdgeColor" COUNTER="5" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Smaller is faster" POSITION="right" ID="ID_911922138" CREATED="1730564182706" MODIFIED="1730564187876">
<edge COLOR="#00ff00"/>
<node TEXT="Instruction size constrained to 1 word" ID="ID_1403187285" CREATED="1730564220964" MODIFIED="1730564252673">
<node TEXT="quick fetching" ID="ID_821199349" CREATED="1730564254515" MODIFIED="1730564259334"/>
</node>
<node TEXT="Only 32 registers" ID="ID_369356390" CREATED="1730564264838" MODIFIED="1730564333165">
<node TEXT="which means addressed with 5bits" ID="ID_625458472" CREATED="1730564333523" MODIFIED="1730564350861"/>
<node TEXT="2^5 = 32" ID="ID_1497413859" CREATED="1730564351830" MODIFIED="1730564359462"/>
<node TEXT="helps keep instruction within 32bit size" ID="ID_808522644" CREATED="1730564375231" MODIFIED="1730564395230"/>
</node>
</node>
<node TEXT="Simplicity Favours Regularity" POSITION="left" ID="ID_1476591038" CREATED="1730564188811" MODIFIED="1730564201112">
<edge COLOR="#ff00ff"/>
<node TEXT="Regularity makes implementation simpler → higher performance at lower cost" ID="ID_1857464165" CREATED="1730564437838" MODIFIED="1730564456637"/>
<node TEXT="Only 3 instuction formats - R/I/J" ID="ID_827146996" CREATED="1730564464106" MODIFIED="1730564506502">
<node TEXT="Simplifies HW design" ID="ID_1241936765" CREATED="1730564511443" MODIFIED="1730564517468"/>
</node>
</node>
<node TEXT="Make the common fast" POSITION="left" ID="ID_578596356" CREATED="1730564525931" MODIFIED="1730564532809">
<edge COLOR="#00ffff"/>
<node TEXT="Small constants common" ID="ID_1031645141" CREATED="1730564541846" MODIFIED="1730564549034"/>
<node TEXT="Immediate Operands avoid load instructions" ID="ID_582199091" CREATED="1730564549925" MODIFIED="1730564575233"/>
</node>
</node>
</map>
