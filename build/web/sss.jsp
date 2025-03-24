<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preview Images</title>
    <style>
        :root {
            --bg: 25% 0.0075 70;
            --pink: 77.75% 0.1003 350.51;
            --gold: 84.16% 0.1169 71.19;
            --mint: 84.12% 0.1334 165.28;
            --mobile--w: 360px;
            --mobile--h: 520px;
            --preview-bg: #fff;
        }

        body {
            background: linear-gradient(
                
            );
            padding: 3rem 10vw;
        }

        .preview__container {
            display: flex;
            flex-wrap: wrap;
            place-items: center;
            place-content: center;
            height: 100%;
        }

        .preview {
            --bg-pos-y--start: 0;
            --bg-pos-y--end: 0;
            --bg-pos-y: var(--bg-pos-y--start);
            --delay: 0;
            --duration: 6s;

            background-clip: padding-box;
            background-image: var(--img);
            background-position-y: var(--bg-pos-y);
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;

            border: var(--outline-w) solid var(--border-color, transparent);
            border-radius: 6px;

            mix-blend-mode: multiply;
            opacity: 0.89;

            scale: 0.85;
            rotate: var(--rotation, -4deg);

            outline: var(--outline-w) solid var(--preview-bg);
            outline-offset: var(--outline-w);

            min-height: var(--mobile--h);
            min-width: var(--mobile--w);

            position: relative;

            animation-name: bg-scroll;
            animation-delay: var(--delay);
            animation-duration: var(--duration);
            animation-fill-mode: forwards;
        }
        .preview:nth-of-type(1) { --bg-pos-y--end: calc(var(--mobile--h) * -0.025); --rotation: 3deg; }
        .preview:nth-of-type(2) { --bg-pos-y--end: calc(var(--mobile--h) * -1.125); --rotation: 3deg; }
        .preview:nth-of-type(3) { --bg-pos-y--end: calc(var(--mobile--h) * -2.2); --duration: 6.5s; --rotation: -1deg; }
        .preview:nth-of-type(4) { --bg-pos-y--end: calc(var(--mobile--h) * -3.3); --duration: 6.75s; --rotation: -5deg; }
        .preview:nth-of-type(5) { --bg-pos-y--end: calc(var(--mobile--h) * -4.38); --duration: 7s; --rotation: -2deg; }

        @keyframes bg-scroll {
            to { background-position-y: var(--bg-pos-y--end); }
        }
    </style>
</head>
<body>
<section class="preview__container" style="--img: url('<%= request.getContextPath() %>/images/us2.png')">
        <article class="preview mobile" tabindex="0"></article>
        <article class="preview mobile" tabindex="0"></article>
        <article class="preview mobile" tabindex="0"></article>
        <article class="preview mobile" tabindex="0"></article>
        <article class="preview mobile" tabindex="0"></article>
    </section>
</body>
</html>