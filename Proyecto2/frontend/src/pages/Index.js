import React, { useState, useRef } from "react";
import { ScrollSync, ScrollSyncPane } from "react-scroll-sync";
import NavBarCustom from "../components/NavBar";
import TextAreaCustom from "../components/TextAreaCustom";
import "../styles/editor.css"
import service from "../services/Service";
import { Graphviz } from 'graphviz-react';
import { saveAs } from "file-saver";
function Index() {
    //HOOK TO LIST THE NUMBER OF LINES OF CODE
    const refGraph = useRef("");
    const [lines, setLines] = useState("");
    const codeToLines = (code) => {
        ref.current = code;
        var numl = code.split("\n").length;
        var l = "";
        for (let i = 0; i < numl; i++) {
            if (!(i === numl - 1)) {
                l += `${i + 1}\n`
            } else {
                l += `${i + 1}`;
            }
        }
        setNewCode(ref.current);
        setLines(l)
    }
    //HOOK TO GET THE ENTERED CODE AND SEND TO THE SERVER
    const ref = useRef(null);
    const handleGetCode = event => {
        console.log("click: " + ref.current);
        let text = ref.current;
        service.parse(text)
            .then(({ consola, erroreslex, erroressintax, erroressemanticos, arbolst }) => {
                setResponse(consola + "\n<LEXICAL ERRORS>\n" + erroreslex + "\n<SINTAX ERRORS>\n" + erroressintax
                    + "\n<SEMANTIC ERRORS>\n" + erroressemanticos);
                console.log(arbolst)
                refGraph.current = arbolst;
            });
    }
    const saveCode = event => {
        const blob = new Blob([newCode], {type:"text/plain;charset=utf-8"});
        saveAs(blob,"code.olc");
    }
    const [response, setResponse] = useState("");
    const readFile = (e) => {
        const file = e.target.files[0];
        if (!file) return;
        const fileReader = new FileReader();
        fileReader.readAsText(file);
        fileReader.onload = () => {
            setNewCode(fileReader.result);
            codeToLines(fileReader.result)
        }
        fileReader.onerror = () => {
            alert(fileReader.error);
        }
    }
    const [newCode, setNewCode] = useState("");
    return (
        <>
            <NavBarCustom />
            <div style={{ display: "flex", marginTop: "0.5%", paddingInline:"20px"}} >
                <button type="button" class="btn btn-success" onClick={handleGetCode} >Run</button>
                <button type="button" class="btn btn-info" onClick={() => { setResponse(""); setLines(""); setNewCode(""); }}>Clean</button>
                <button type="button" class="btn btn-success" onClick={saveCode} >Save</button>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                    </div>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="inputGroupFile01" accept=".txt, .olc"
                            aria-describedby="inputGroupFileAddon01" onChange={readFile} multiple={false} />
                        <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                    </div>
                </div>
            </div>
            <ScrollSync>
                <div className={"scroll-sync-code-line"} style={{
                    display: 'flex', position: 'relative',
                    height: 420, paddingTop: "0.8%", paddingBottom: "0.8%"
                }}>
                    <ScrollSyncPane>
                        <div style={{ overflow: 'auto', width: "6%" }}>
                            <TextAreaCustom idC={"lines"} classN={"lines"} value={lines} text={"Lines:"}>1</TextAreaCustom>
                        </div>
                    </ScrollSyncPane>
                    <ScrollSyncPane>
                        <div style={{ overflow: 'auto', width: "94%" }}>
                            <TextAreaCustom ref={ref} idC={"code"} classN={"code"} handlerChange={codeToLines} value={newCode} text={"CODE:"} />
                        </div>
                    </ScrollSyncPane>
                </div>
            </ScrollSync>
            <div className={"scroll-sync-code-line"} style={{
                display: 'flex', position: 'relative', height: 300,
                paddingTop: "0.8%", paddingBottom: "0.8%"
            }}>
                <div style={{ overflow: "auto", width: "100%" }}>
                    <TextAreaCustom idC={"console"} classN={"console"} value={response} text={"OUTPUT"} />
                </div>
            </div>
            <div className={"scroll-sync-code-line"}>
                <div style={{color:"white"}}>AST:</div>
                <div style={{marginTop:"30px", marginBottom:"30px",marginLeft:"40px",marginRight:"40px", minHeight:"500px", paddingBottom:"40px",background:"black"}}>
                    <Graphviz ref={refGraph} dot={"digraph G{\n" + refGraph.current + "\n}"}
                        options={{zoom: true, width: "100%", height:600, fit:true}}
                        style={{ width: "100%" }} />
                </div>
            </div>
        </>
    );
}
export default Index;