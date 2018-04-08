import React, { Component } from 'react'
import Editor from 'draft-js-plugins-editor'
import createMarkdownPlugin from 'draft-js-markdown-plugin'
import { mdToDraftjs, draftjsToMd } from 'draftjs-md-converter'
import {
  EditorState,
  ContentState,
  convertToRaw,
  convertFromRaw
} from 'draft-js'

const FIELD_SELECTOR = '[data-behavior~=composer_field]'

class Composer extends Component {
  state = {
    name: '',
    body: EditorState.createEmpty(),
    plugins: [createMarkdownPlugin()]
  }

  componentDidMount() {
    this.fieldSelector = `${FIELD_SELECTOR}[name='${this.props.name}']`
    const value = $(this.fieldSelector).val()
    if (!_.isEmpty(value)) {
      const raw = mdToDraftjs(value)
      const body = EditorState.createWithContent(convertFromRaw(raw))
      this.setState({ body })
    }
  }

  changeBody = body => {
    this.setState({ body })
    const content = this.state.body.getCurrentContent()
    const text = draftjsToMd(convertToRaw(content))
    $(this.fieldSelector).val(text)
  }

  render() {
    const { plugins, body } = this.state
    return (
      <Editor
        editorState={body}
        onChange={e => this.changeBody(e)}
        plugins={plugins}
        spellCheck={true}
        autoCapitalize="sentences"
        autoComplete="on"
        autoCorrect="on"
        stripPastedStyles={true}
        {...this.props}
      />
    )
  }
}

export default Composer
