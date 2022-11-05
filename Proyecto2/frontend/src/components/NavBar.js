import React from "react";
function NavBarCustom() {
    return (
        <>
            <nav class="navbar navbar-expand-lg navbar navbar-dark bg-dark">
                <a class="navbar-brand" href="*">MFMScript</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="*">Technical Manual</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="*">User Manual</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="*" role="button" data-toggle="dropdown" aria-expanded="false">
                                Reports
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="*">AST</a>
                                <a class="dropdown-item" href="*">Symbol Table</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="*">Syntax Errors</a>
                                <a class="dropdown-item" href="*">Lexical Errors</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </>
    );
}
export default NavBarCustom;