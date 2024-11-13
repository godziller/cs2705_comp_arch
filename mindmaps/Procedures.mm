<map version="freeplane 1.9.13">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="Procedures" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1730563129436" STYLE="oval">
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
<hook NAME="AutomaticEdgeColor" COUNTER="9" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Use Label to name the procedure" POSITION="right" ID="ID_815587545" CREATED="1730563059201" MODIFIED="1730563082674">
<edge COLOR="#ff0000"/>
<node TEXT="Remember, Label is just an address" ID="ID_693316688" CREATED="1730563083026" MODIFIED="1730563090317"/>
</node>
<node TEXT="Calling: jal [label name]" POSITION="right" ID="ID_39402783" CREATED="1730563154292" MODIFIED="1730563187137">
<edge COLOR="#00ff00"/>
<node TEXT="Does 2 things behind the scenes" ID="ID_254176681" CREATED="1730563187552" MODIFIED="1730563201898"/>
<node TEXT="1) new PC set to address of label/procedure" ID="ID_1613768868" CREATED="1730563202338" MODIFIED="1730563220570"/>
<node TEXT="2) $ra set to the next address immediately after jal" ID="ID_223297874" CREATED="1730563221181" MODIFIED="1730563257525">
<node TEXT="Why?" ID="ID_1213294645" CREATED="1730563257808" MODIFIED="1730563263080"/>
<node TEXT="Need to know how to navigate back to from where you were called" ID="ID_1318726401" CREATED="1730563263787" MODIFIED="1730563279000"/>
</node>
</node>
<node TEXT="Procedure will always end with a jr $ra" POSITION="left" ID="ID_436570285" CREATED="1730563330395" MODIFIED="1730563344896">
<edge COLOR="#ff00ff"/>
</node>
<node TEXT="If you have nested procedures, need to save ra on stack to ensure you can restore it on every bounce back to the start of the tree" POSITION="left" ID="ID_1768845559" CREATED="1730563352985" MODIFIED="1730563382702">
<edge COLOR="#00ffff"/>
</node>
<node TEXT="RULES/GUIDELINES:" POSITION="right" ID="ID_1990570627" CREATED="1730563393397" MODIFIED="1730563404502">
<edge COLOR="#7c0000"/>
<node TEXT="a0, a1, a2, a3 registered typically used for arguement passing to procedure" ID="ID_1594858364" CREATED="1730563404859" MODIFIED="1730563444371"/>
<node TEXT="v0, v1 used for returning results to caller" ID="ID_180325012" CREATED="1730563445409" MODIFIED="1730563456931"/>
<node TEXT="Temporary registers - t0-t9" ID="ID_181631922" CREATED="1730563471937" MODIFIED="1730563486958">
<node TEXT="Free for all. Do not trust the procedure to keep them safe" ID="ID_1686646795" CREATED="1730563488275" MODIFIED="1730563506002"/>
<node TEXT="Save them yourself before you call a procedure if you need their values to be consistent after returning from procedure" ID="ID_879461238" CREATED="1730563506407" MODIFIED="1730563529625"/>
</node>
<node TEXT="Saved Registers - S0-&gt;s7" ID="ID_1479776865" CREATED="1730563531528" MODIFIED="1730563544384">
<node TEXT="Procedure SHOULD not overwrite" ID="ID_677317532" CREATED="1730563544922" MODIFIED="1730563563403"/>
<node TEXT="Gentlemans agreement to leave them in the same state as you got them" ID="ID_958412831" CREATED="1730563564046" MODIFIED="1730563582242"/>
<node TEXT="If you need to use them in the procedure, then save the incoming values of these S* registers to stack" ID="ID_473478088" CREATED="1730563582853" MODIFIED="1730563604375"/>
<node TEXT="Then just before you call jr $ra, restore their values from the stack." ID="ID_71084259" CREATED="1730563605089" MODIFIED="1730563626144"/>
</node>
</node>
<node TEXT="STACK" POSITION="left" ID="ID_118942053" CREATED="1730563637547" MODIFIED="1730563642437">
<edge COLOR="#00007c"/>
<node TEXT="Remember Stack grows downwards" ID="ID_604197764" CREATED="1730563643711" MODIFIED="1730563657201">
<node TEXT="To grow stack add minus the size you want" ID="ID_677324824" CREATED="1730563659591" MODIFIED="1730563683356"/>
<node TEXT="for 2 slots do a -8" ID="ID_1354118970" CREATED="1730563684073" MODIFIED="1730563696047">
<node TEXT="remember byte addressable, 8 bytes = 2 32bit slots" ID="ID_291346806" CREATED="1730563696654" MODIFIED="1730563719485"/>
<node TEXT="Then store your values in SP-4 or SP-0&#xa;-8 is the last guys slot" ID="ID_1585514143" CREATED="1730563725341" MODIFIED="1730563759816"/>
</node>
</node>
<node TEXT="For restoring values pop" ID="ID_1343313368" CREATED="1730563770364" MODIFIED="1730563778721">
<node TEXT="poping means:&#xa;a) take the values out of the slot and put them in the registers you wanted to save and restore" ID="ID_358005706" CREATED="1730563779625" MODIFIED="1730563809520"/>
<node TEXT="b) Move the stack pointer back to the position you got it when you began the procedure" ID="ID_1386714575" CREATED="1730563814048" MODIFIED="1730563835670"/>
</node>
</node>
<node TEXT="Leafs" POSITION="left" ID="ID_1956934801" CREATED="1730563845713" MODIFIED="1730563850191">
<edge COLOR="#007c00"/>
<node TEXT="Leaf: Does not call/jump to a procedure" ID="ID_364391248" CREATED="1730563875531" MODIFIED="1730563889725"/>
<node TEXT="Non-Leaf: you will find a jump to a procedure" ID="ID_646317859" CREATED="1730563892884" MODIFIED="1730563905597">
<node TEXT="RULES to follow:" ID="ID_1297535305" CREATED="1730563915866" MODIFIED="1730563925306"/>
<node TEXT="save the ra on the stack" ID="ID_1530164084" CREATED="1730563925693" MODIFIED="1730563931847"/>
<node TEXT="save any registers you want to be unchanged when your return" ID="ID_616864861" CREATED="1730563940218" MODIFIED="1730563963706"/>
<node TEXT="when procedure done its job, restore all the above" ID="ID_196934461" CREATED="1730563964872" MODIFIED="1730563979150"/>
</node>
</node>
</node>
</map>
