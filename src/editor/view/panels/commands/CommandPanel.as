/**
 * Created by borisenki on 07.09.16.
 */
package editor.view.panels.commands
{
import editor.view.panels.*;

import com.bit101.components.Panel;
import com.bit101.utils.MinimalConfigurator;

import editor.model.vo.QuestDialogVO;

import flash.display.Sprite;

public class CommandPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/command/command_panel.xml", mimeType="application/octet-stream")]
	private var command_panel_Class:Class;

	public static const QUEST_COMMANDS:int = 2;
	public static const DIALOG_COMMANDS:int = 4;
	public static const ANSWER_COMMANDS:int = 8;

	private var config:MinimalConfigurator;
	private var rootPanel:Panel;
	private var panelsContainer:Sprite;
	private var panelsContainerHeight:int;

	private var _questId:int;
	private var _dialogId:int;
	private var _answerId:int;

	public function CommandPanel()
	{
		init();
	}

	private function init():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new command_panel_Class()));
		rootPanel = config.getCompById("rootPanel") as Panel;
		panelsContainer = new Sprite();
		addChild(panelsContainer);
	}

	public function setEnable(enabled:Boolean):void
	{
		rootPanel.enabled = enabled;
	}

	public function fillPanel(mask:int):void
	{
		panelsContainer.removeChildren();
		panelsContainerHeight = 0;
		if (QUEST_COMMANDS & mask)
		{
			addQuestCommands();
		}
		if (DIALOG_COMMANDS & mask)
		{
			addDialogCommands();
		}
		if (ANSWER_COMMANDS & mask)
		{
			addAnswerCommands();
		}
	}

	private function addQuestCommands():void
	{
		var panel:QuestCommandsPanel = new QuestCommandsPanel();
		panel.questId = _questId;
		panel.y = panelsContainerHeight;
		panelsContainer.addChild(panel);
		panelsContainerHeight += 40;
	}

	private function addDialogCommands():void
	{
		var panel:DialogCommandsPanel = new DialogCommandsPanel();
		panel.dialogId = _dialogId;
		panel.y = panelsContainerHeight;
		panelsContainer.addChild(panel);
		panelsContainerHeight += 65;
	}

	private function addAnswerCommands():void
	{
		var panel:AnswerCommandsPanel = new AnswerCommandsPanel();
		panel.answerId = _answerId;
		panel.y = panelsContainerHeight;
		panelsContainer.addChild(panel);
		panelsContainerHeight += 40;
	}

	public function set questId(value:int):void
	{
		_questId = value;
	}

	public function set dialogId(value:int):void
	{
		_dialogId = value;
	}

	public function set answerId(value:int):void
	{
		_answerId = value;
	}
}
}
