import React from "react";
import { TextareaAutosize } from "@mui/base"
import "../styles/editor.css"
function TextAreaCustom(props) {
    const handlerChangeEditor = (evt) => {
        if (props.idC === "code") {
            props.handlerChange(evt.target.value);
        }
    }
    return (
        <>
            <div class={"form-group " + props.divClass}>
                <label for={props.idC} style={{ color: "#ffffff" }}>{props.text}</label>
                <TextareaAutosize class={"form-control " + props.classN} id={props.idC}
                    onChange={handlerChangeEditor} value={props.value} readOnly={props.read} />
            </div>

        </>
    );
}

export default TextAreaCustom;